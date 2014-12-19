package com.inspur.sdmz.apply.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.sdmz.apply.data.SamApplyHandle;

/*
 * 救助业务
 */
public interface ISamApplyHandleDao extends BaseCURD<SamApplyHandle>{

	public void delete(String[] delIds);
}