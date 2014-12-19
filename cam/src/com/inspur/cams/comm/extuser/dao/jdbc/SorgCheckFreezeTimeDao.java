package com.inspur.cams.comm.extuser.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import com.inspur.cams.comm.extuser.dao.ISorgCheckFreezeTimeDao;
import com.inspur.cams.comm.extuser.data.SorgCheckFreezeTime;

/**
 * 社会组织年检冻结账号时间配置表Dao实现类
 * @author 闫亮亮
 * @date 2012年7月16日
 */
public class SorgCheckFreezeTimeDao extends EntityDao<SorgCheckFreezeTime> implements ISorgCheckFreezeTimeDao {
	// 根据ID逻辑删除时间配置
	public static String DELETE_BY_FREEZE_ID = "DELETE FROM SORG_CHECK_FREEZE_TIME  WHERE FREEZE_ID=?";
	@SuppressWarnings("unchecked")
	@Override
	protected Class getEntityClass() {
		return SorgCheckFreezeTime.class;
	}
	
	public void insertSorgCheckFreezeTime(SorgCheckFreezeTime sorgCheckFreezeTime){
		insert(sorgCheckFreezeTime);
	}

	public void deteleSorgCheckFreezeTime( SorgCheckFreezeTime sorgCheckFreezeTime) {
		int[] types = new int[] {Types.VARCHAR};
		Object[] objs = new Object[] {sorgCheckFreezeTime.getFreezeId()};
		executeUpdate(DELETE_BY_FREEZE_ID, types, objs);
	}

	public void updateSorgCheckFreezeTime( SorgCheckFreezeTime sorgCheckFreezeTime) {
		update(sorgCheckFreezeTime);
	}
	
}
