package com.inspur.cams.marry.base.dao;

import java.math.BigDecimal;
import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.marry.base.data.MrmFdy;

/**
 * @title:IMrmFdyDao
 * @description:
 * @author:
 * @since:2012-02-02
 * @version:1.0
*/
 public interface IMrmFdyDao extends BaseCURD<MrmFdy>{
	public void save(List<MrmFdy> list);
	public BigDecimal getFdyNum(String deptId);
	public List getFdyRyly (String deptId);
}

