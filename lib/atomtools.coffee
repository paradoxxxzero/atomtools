module.exports =
  activate: (state) ->
    atom.workspaceView.command "atomtools:delete-indentation", ->
      editor = atom.workspace.getActivePaneItem()
      return unless editor
      buffer = editor.getBuffer()
      buffer.beginTransaction()
      editor.moveCursorUp()
      editor.joinLines()
      buffer.commitTransaction()

    atom.workspaceView.command "atomtools:trim-and-newline", ->
      editor = atom.workspace.getActivePaneItem()
      return unless editor
      buffer = editor.getBuffer()
      buffer.beginTransaction()
      cursor = editor.getCursor()
      while buffer.getTextInRange(cursor.getScreenRange()) is ' '
        editor.delete()
      backRange = ->
        cursor.getScreenRange().constructor.fromPointWithDelta(
          cursor.getScreenPosition(), 0, -1)
      while buffer.getTextInRange(backRange()) is ' '
        editor.backspace()
      editor.insertNewline()
      buffer.commitTransaction()
