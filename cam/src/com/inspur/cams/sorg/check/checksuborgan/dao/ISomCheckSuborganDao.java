package com.inspur.cams.sorg.check.checksuborgan.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checksuborgan.data.SomCheckSuborgan;

/**
 * @title:分支、代表、办事、专项基金管理机构情况dao接口
 * @description:
 * @author:
 * @since:2012-01-07
 * @version:1.0
 */
public interface ISomCheckSuborganDao extends BaseCURD<SomCheckSuborgan> {
	public void save(List<SomCheckSuborgan> list);
	public void deleteByTaskCode(String taskCode,String organType);
}
