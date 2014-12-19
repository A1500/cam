package com.inspur.cams.marry.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.marry.base.data.MrmPybzy;

/**
 * @title:IMrmPybzyDao
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
 public interface IMrmPybzyDao extends BaseCURD<MrmPybzy>{
	public void save(List<MrmPybzy> list);
}

