package com.inspur.cams.marry.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.marry.base.data.MrmBulu;

/**
 * @title:IMrmBuluDao
 * @description:
 * @author:
 * @since:2012-02-23
 * @version:1.0
*/
 public interface IMrmBuluDao extends BaseCURD<MrmBulu>{
	public void save(List<MrmBulu> list);
	public List getBuluInfo(String deptId);
}

