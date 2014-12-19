package com.inspur.cams.sorg.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.base.data.SomOrganHis;

/**
 * @title:ISomOrganHisDao
 * @description:
 * @author:
 * @since:2012-05-28
 * @version:1.0
*/
 public interface ISomOrganHisDao extends BaseCURD<SomOrganHis>{
	public void save(List<SomOrganHis> list);
}

