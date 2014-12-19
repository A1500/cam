/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

// Register a templates definition set named "default".
CKEDITOR.addTemplates( 'default',
{
	// The name of sub folder which hold the shortcut preview images of the
	// templates.
	imagesPath : CKEDITOR.getUrl( CKEDITOR.plugins.getPath( 'templates' ) + 'templates/images/' ),

	// The templates definitions.
	templates :
		[
			{
				title: '祝福',
				image: 'fishpaper.jpg',
				description: '贺岁祝福',
				html:
					'<table style="background-color:#C13202;background-repeat:no-repeat;" width="99%" align="center" border="0" cellspacing="0" cellpadding="0"><tr><td valign="top">'
					+ '<table style="background-repeat:no-repeat; font-size:1px;" align="center" width="100%" border="0"	background="'
					+ CKEDITOR.getUrl( CKEDITOR.plugins.getPath('templates') + 'templates/images/') + 'paper1/paper001_001.jpg"'
					+ 'height="123" cellspacing="0" cellpadding="0"><tr><td style="font-size:1px;" valign="top" width="577"></td><td style="font-size:1px;" valign="top">&nbsp;</td><td style="font-size:1px;" valign="top"></td></tr></table><table style="background-repeat:repeat-y;font-size:1px;" background="'
					+ CKEDITOR.getUrl( CKEDITOR.plugins.getPath('templates') + 'templates/images/') + 'paper1/paper001_003.jpg"'
					+ 'align="center" width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td style="background-repeat:no-repeat;font-size:1px;" valign="top" width="45" background="'
					+ CKEDITOR.getUrl( CKEDITOR.plugins.getPath('templates') + 'templates/images/') + 'paper1/paper001_002.jpg">'
					+ '</td><td style="background-repeat:repeat;color:#033547;font-size:14px;line-height:42px;padding:10px 5px 15px 10px;text-align:left;word-wrap:break-word;" valign="top"	background="'
					+ CKEDITOR.getUrl( CKEDITOR.plugins.getPath('templates') + 'templates/images/') + 'paper1/paper001_005.jpg"'
					+ 'id="mail_stationery">亲爱的朋友：<BR>	您好！<BR><BR><BR><BR><BR><BR><BR><BR>致<BR>礼！<BR><BR><BR></td><td style="background-repeat:repeat-y;font-size:1px;" valign="top" width="45"	 background="'
					+ CKEDITOR.getUrl( CKEDITOR.plugins.getPath('templates') + 'templates/images/') + '/paper1/paper001_004.jpg">'
					+ '</td></tr></table><table style="background-color:#C13202;font-size:1px;" align="center" width="100%" height="45"	border="0" cellspacing="0" cellpadding="0"><tr><td style="font-size:1px;" valign="top"></td><td style="font-size:1px;" valign="top">&nbsp;</td><td style="font-size:1px;" valign="top"></td></tr></table></td></tr></table>'
			}
		]
});
