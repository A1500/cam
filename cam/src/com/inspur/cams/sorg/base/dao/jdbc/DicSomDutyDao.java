package com.inspur.cams.sorg.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.IDicSomDutyDao;
import com.inspur.cams.sorg.base.data.DicSomDuty;

/**
 * 社会组织职务dao实现类
 * @author Jiangzhaobao
 * @date 2011-6-18
 */
public class DicSomDutyDao extends EntityDao<DicSomDuty> implements IDicSomDutyDao {
	
	@Override
	protected Class<DicSomDuty> getEntityClass() {
		return DicSomDuty.class;
	}

}
