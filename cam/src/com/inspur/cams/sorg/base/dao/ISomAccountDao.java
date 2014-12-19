package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.base.data.SomAccount;

/**
 * 社会组织账户dao接口
 * @author jiangzhaobao
 * @date 2011-05-10
*/
public interface ISomAccountDao extends BaseCURD<SomAccount> {
	public void del(String taskCode);
}
