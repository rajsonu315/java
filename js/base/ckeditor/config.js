/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	 /*     Define changes to default configuration here. For example:
	        config.language = 'fr';
	        config.uiColor = '#99F299';               
                config.scayt_autoStartup = true;    // for enable spell checker.
                config.resize_maxWidth = ;
                config.resize_maxHeight = 600;  */
           //   config.uiColor = '#FFCD69';
                config.height = 400;
                config.width = 590;
                config.removePlugins = 'elementspath';
                config.toolbar_Full =
[
   
    ['Cut','Copy','Paste', 'Scayt'],
    ['Table','HorizontalRule','PageBreak'],
    ['Undo','Redo','-','Find','Replace'],
    ['NumberedList','BulletedList','-','Outdent','Indent'],
    ['TextColor','BGColor','FontSize'],
    '/',
    ['Bold','Italic','Underline','Strike','Subscript','Superscript'],
    ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','Styles','Format','Font']
  
    
   
    
];
         


 /*       config.removePlugins = [['Source','-','Save'],
          ['NewPage','Preview','Templates','Print','Maximize'],
         ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
         '/',
         ['Image','Flash','HorizontalRule','Smiley','SpecialChar','PageBreak'],['Link','Unlink','Anchor'],
         ['Blockquote','CreateDiv'],['ShowBlocks','-','About']
] ;  */


};