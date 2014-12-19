package com.inspur.cams.comm.dicm.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.comm.dicm.data.DicManage;

/***
 * 字典信息维护dao接口
 * @author luguosui
 * @date 2011-8-31
 */
public interface IDicManageDao extends BaseCURD<DicManage>{
	/**
	 * AAA
	 */
	public void save(List<DicManage> list);
}
