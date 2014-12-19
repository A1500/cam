package com.inspur.cams.sorg.check.somcheckflow.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.somcheckflow.data.SomCheckFlow;

/**
 * @title:ISomCheckFlowDao
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
*/
 public interface ISomCheckFlowDao extends BaseCURD<SomCheckFlow>{
	public void save(List<SomCheckFlow> list);
}

