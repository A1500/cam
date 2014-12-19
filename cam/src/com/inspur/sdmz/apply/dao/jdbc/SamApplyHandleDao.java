package com.inspur.sdmz.apply.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.sdmz.apply.dao.ISamApplyHandleDao;
import com.inspur.sdmz.apply.data.SamApplyHandle;


/**
 * 业务管理办理信息对应的dao实现
 * @author Administrator
 * @date 2011-4-26
 */
public class SamApplyHandleDao extends EntityDao<SamApplyHandle> implements ISamApplyHandleDao {
	public SamApplyHandleDao() throws Exception {
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return SamApplyHandle.class;
	}
	
	/**
	 * 业务管理_办理信息表中对应信息的删除
	 */
	public void delete(String[] delIds) {
		String[] sql = new String[delIds.length];
		for (int i = 0; i < delIds.length; i++) {
			sql[i] = "delete from SAM_APPLY_HANDLE where APPLY_ID='" + delIds[i] + "'";
		}
		batchUpdate(sql);	
	}

}
