package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.base.data.SomOrganCode;

/**
 * 组织机构代码备案dao接口
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public interface ISomOrganCodeDao extends BaseCURD<SomOrganCode> {
	
	public void del(String taskCode);

}
