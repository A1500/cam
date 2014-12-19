package com.inspur.cams.marry.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.base.data.MrmPhotoInfo;

/**
 * @title:IMrmPhotoInfoDao
 * @description:
 * @author:
 * @since:2012-03-14
 * @version:1.0
*/
 public interface IMrmPhotoInfoDao extends BaseCURD<MrmPhotoInfo>{
	public void save(List<MrmPhotoInfo> list);
	public DataSet queryPhotoInfo(ParameterSet pset);
}

