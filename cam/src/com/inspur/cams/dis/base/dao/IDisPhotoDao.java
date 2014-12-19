package com.inspur.cams.dis.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.dis.base.data.DisPhoto;

/**
 * @title:IDisPhotoDao
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
 public interface IDisPhotoDao extends BaseCURD<DisPhoto>{
	public void save(List<DisPhoto> list);
	/**
	 * 根据外键infoId删除所有与之相关的图片记录
	 * @param infoId
	 */
	public void deleteInInfoId(String infoId);
	
}

