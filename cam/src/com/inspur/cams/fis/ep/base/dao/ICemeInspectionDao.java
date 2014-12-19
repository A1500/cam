package com.inspur.cams.fis.ep.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.fis.ep.base.data.CemeInspection;


/**
 * @title:IInspectionDao
 * @description:公墓年检表单dao接口
 * @author:lidongdong
 * @since:2011-11-17
 * @version:1.0
*/
 public interface ICemeInspectionDao extends BaseCURD<CemeInspection>{
	public void save(List<CemeInspection> list);
}

