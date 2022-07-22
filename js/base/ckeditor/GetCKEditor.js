
GetCKEditor = function() {
var self = this ;
var editor;
self.createEditor = function() {
	if ( editor )
		return;

	var html = document.getElementById( 'editorcontents' ).innerHTML;

	// Create a new editor inside the <div id="editor">, setting its value to html
	var config = {};
	editor = CKEDITOR.appendTo( 'editor', config, html );
}

self.removeEditor = function()
{
	if ( !editor )
		return;

	// Retrieve the editor contents. In an Ajax application, this data would be
	// sent to the server or used in any other way.
	document.getElementById( 'editorcontents' ).innerHTML = editor.getData();
	document.getElementById( 'contents' ).style.display = '';

	// Destroy the editor.
	editor.destroy();
	editor = null;
}
};
var getCKEditor = new GetCKEditor();