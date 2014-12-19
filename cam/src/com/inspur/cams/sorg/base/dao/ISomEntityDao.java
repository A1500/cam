package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.base.data.SomEntity;

/**
 * 社会组织举办实体dao接口
 * @author shgtch
 * @date 2011-5-11
 */
public interface ISomEntityDao extends BaseCURD<SomEntity> {
	public void del(String taskCode);
}
