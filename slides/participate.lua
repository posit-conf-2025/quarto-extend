local function column(width)
  return pandoc.Attr("", {'column'}, {width=width})
end 

Div = function(el)
  if not el.classes:includes("participate") then
    return nil
  end

  local content = pandoc.Div(el.content, pandoc.Attr("", {'question'}, {}))

  if not quarto.format.isHtmlSlideOutput() then
    return content
  end

  local boilerplate = pandoc.Para(pandoc.Inlines({
    pandoc.Image(
      "",
      "Discord-Logo-Black.png", 
      nil, 
      pandoc.Attr("", {}, {alt="Discord Logo"})
    ),
    pandoc.Str("Answer in our "),
    pandoc.Link(
      pandoc.Str("Discord"), 
      pandoc.utils.stringify(quarto.metadata.get("discord")))
  }))
  
  local inner_columns = pandoc.Blocks({
    pandoc.Div(content, column('75%')), 
    pandoc.Div(boilerplate, column('25%'))
  })
  local result = pandoc.Div(inner_columns, pandoc.Attr("", {"columns"}, {}))
  return result
end