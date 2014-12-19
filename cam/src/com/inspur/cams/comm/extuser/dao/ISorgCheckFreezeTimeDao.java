package com.inspur.cams.comm.extuser.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.comm.extuser.data.SorgCheckFreezeTime;


/**
 * 社会组织年检冻结账号时间配置表Dao接口
 * @author 闫亮亮
 * @date 2012年7月16日
 */
public interface ISorgCheckFreezeTimeDao extends BaseCURD<SorgCheckFreezeTime>{
	public void insertSorgCheckFreezeTime(SorgCheckFreezeTime sorgCheckFreezeTime);	
	
	public void updateSorgCheckFreezeTime(SorgCheckFreezeTime sorgCheckFreezeTime);
	
	public void deteleSorgCheckFreezeTime(SorgCheckFreezeTime sorgCheckFreezeTime);
	
}
