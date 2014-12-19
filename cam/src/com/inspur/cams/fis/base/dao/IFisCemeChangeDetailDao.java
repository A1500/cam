package com.inspur.cams.fis.base.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.fis.base.data.FisCemeChangeDetail;

/**
 * 公墓信息变更备案明细表dao
 * @author 
 * @date 2013-08-01
 */
public interface IFisCemeChangeDetailDao extends BaseCURD<FisCemeChangeDetail> {

	void deleteByChangeId(String changeId);

}