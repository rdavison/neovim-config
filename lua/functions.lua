local ts_query1 = vim.treesitter.query.parse(
  'python',
  [[
(class_definition
  name: (identifier) @cname
  body: (block           
	  (decorated_definition
	    definition: (function_definition
		  name: (identifier) @fname (#any-of? @fname "get" "head" "post" "put" "delete" "connect" "options" "trace" "patch")
		  parameters: (_) @params
		  return_type: (_) @ret
			  ) @def)))
]]
)
local ts_query2 = vim.treesitter.query.parse(
  'python',
  [[
(class_definition
  name: (identifier) @cname
  body: (block           
	(function_definition
		  name: (identifier) @fname (#any-of? @fname "get" "head" "post" "put" "delete" "connect" "options" "trace" "patch")
		  parameters: (_) @params
		  return_type: (_) @ret
			  ) @def))
]]
)
local split_lines = function(str)
  local lines = {}
  for s in str:gmatch '[^\r\n]+' do
    table.insert(lines, s)
  end
  return lines
end

local normalize_item = function(input)
  local result = ''
  if input then
    print(result)
    -- Step 1: Split the string on newlines
    local lines = {}
    for line in input:gmatch '[^\n]+' do
      table.insert(lines, line)
    end

    -- Step 2: Strip leading spaces from each line
    for i, line in ipairs(lines) do
      lines[i] = line:match '^%s*(.*)' -- Remove leading whitespace
    end

    -- Step 3: Concatenate lines with a space as the delimiter
    result = table.concat(lines, ' ')
  end
  return result
end

local function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then
        k = '"' .. k .. '"'
      end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

local pretty_item = function(item)
  -- local cname = normalize_item(item['cname'])
  -- local fname = normalize_item(item['fname'])
  -- local params = normalize_item(item['params'])
  -- local return_type = normalize_item(item['return_type'])
  return { table.concat({ tostring(item['cname']), tostring(item['fname']) }, '.') }
end

local get_root = function(bufn)
  local parser = vim.treesitter.get_parser(bufn, 'python', {})
  local tree = parser:parse()[1]
  return tree:root()
end

local get_items = function(nsrt, bufn, query)
  bufn = bufn or vim.api.nvim_get_current_buf()

  if vim.bo[bufn].filetype ~= 'python' then
    vim.notify 'can only be used in python'
    return
  end

  local root = get_root(bufn)

  local items = {}
  for id, node, metadata, match in query:iter_captures(root, bufn, 0, -1) do
    local name = query.captures[id]
    local data = vim.treesitter.get_node_text(node, bufn)
    local match_id = match:info()
    if not items[match_id] then
      items[match_id] = {}
    end
    local item = items[match_id]
    item[name] = data
  end
  return items
end

local append_lines = function(bufn, items)
  for _, item in pairs(items) do
    vim.api.nvim_buf_set_lines(bufn, -1, -1, false, pretty_item(item))
  end
end

local api_magic = function()
  local bufn = vim.api.nvim_get_current_buf()
  local items1 = get_items('items1', bufn, ts_query1)
  local items2 = get_items('items2', bufn, ts_query2)
  append_lines(bufn, items1)
  append_lines(bufn, items2)
end

vim.api.nvim_create_user_command('DumpDjangoViews', api_magic, {})
