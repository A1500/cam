package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.ComPhoto;
import com.inspur.cams.jcm.domain.IComPhotoDomain;

/**
 * 人员照片表cmd
 * @author 
 * @date 2014-05-16
 */
public class ComPhotoCmd extends BaseAjaxCommand {

	private IComPhotoDomain comPhotoDomain = ScaComponentFactory
			.getService(IComPhotoDomain.class, "comPhotoDomain/comPhotoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		ComPhoto comPhoto = (ComPhoto) record.toBean(ComPhoto.class);
		comPhotoDomain.insert(comPhoto);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		ComPhoto comPhoto = (ComPhoto) record.toBean(ComPhoto.class);
		comPhotoDomain.update(comPhoto);
	}
	
	// 删除
	public void delete() {
		String photoId = (String) getParameter("photoId");
		comPhotoDomain.delete(photoId);
	}
	
}