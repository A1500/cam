package com.inspur.cams.comm.comphoto.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.comm.comphoto.data.ComPhoto;

public interface IComPhotoDao extends BaseCURD<ComPhoto>{
	public ComPhoto insertPhoto(ComPhoto comPhoto);
}
