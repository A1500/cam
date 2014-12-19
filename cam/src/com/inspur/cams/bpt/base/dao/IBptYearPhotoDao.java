package com.inspur.cams.bpt.base.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.bpt.base.data.BptYearPhoto;

/**
 * IBptYearPhotoDao
 * @description:
 * @author:
 * @since:2011-05-12
 * @version:1.0
*/
 public interface IBptYearPhotoDao extends BaseCURD<BptYearPhoto>{
	
	 public void deleteYearPhoto(String photoId);
}

