package com.inspur.cams.sorg.check.checksystems.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checksystems.data.SomCheckSystems;

/**
 * @title:内部制度建设情况dao接口
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
 */
public interface ISomCheckSystemsDao extends BaseCURD<SomCheckSystems> {
	public void save(List<SomCheckSystems> list);
}
