/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	//使用中文简体语言
    config.language = 'zh-cn';
    //自定义工具栏
    config.toolbar = 'MyToolbar';
    config.skin = "office2003";
    config.height="300";
    config.width="100%";
    config.font_names = '宋体/宋体;黑体/黑体;仿宋/仿宋_GB2312;楷体/楷体_GB2312;隶书/隶书;幼圆/幼圆;'+ config.font_names ;    
	config.bodyId = "CkBodyId";	
	config.font_defaultLabel = "宋体";
	config.fontSize_defaultLabel = "16";
	config.fontSize_sizes = '10/10px;12/12px;14/14px;16/16px;18/18px;20/20px;22/22px;24/24px;26/26px;28/28px;36/36px;48/48px;72/72px'; 
	config.baseFloatZIndex = 8000;
	config.toolbar_MyToolbar =
    [
        ['Templates' ,  'Bold','Italic','Underline','Strike'],
        ['Font','FontSize'],
        ['TextColor','BGColor'],
        ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
        ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
        ['Preview','-'],
        ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
        ['Link','Unlink'],
        ['Image','Flash','HorizontalRule','Smiley']
    ];
    
};

CKEDITOR.on( 'dialogDefinition', function( ev )
	{
		// Take the dialog name and its definition from the event
		// data.
		var dialogName = ev.data.name;
		var dialogDefinition = ev.data.definition;

		// Check if the definition is from the dialog we're
		// interested on (the "Link" dialog).
        // 移除默认的链接对话框的target与advanced标签页
		if ( dialogName == 'link')
		{
			dialogDefinition.removeContents( 'target' );
            dialogDefinition.removeContents( 'advanced' );
		}
		// 移除默认的图片对话框的target与advanced标签页
		if(dialogName == 'image')
		{
			dialogDefinition.removeContents( 'advanced' );
            dialogDefinition.removeContents( 'Link' );
		}
		if(dialogName == 'flash'){
			dialogDefinition.removeContents( 'advanced' );
            dialogDefinition.removeContents( 'properties' );
		}
	});