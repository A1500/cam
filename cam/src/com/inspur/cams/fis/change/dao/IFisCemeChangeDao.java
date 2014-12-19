package com.inspur.cams.fis.change.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.fis.base.data.FisCemeInfo;

public interface IFisCemeChangeDao extends BaseCURD<FisCemeInfo> {
	public void save(List<FisCemeInfo> list);
}
