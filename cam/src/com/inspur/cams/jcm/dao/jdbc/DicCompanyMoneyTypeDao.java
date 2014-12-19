package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IDicCompanyMoneyTypeDao;
import com.inspur.cams.jcm.data.DicCompanyMoneyType;

/**
 * 单位经费类别dao
 * @author 
 * @date 2014-05-21
 */
public class DicCompanyMoneyTypeDao extends EntityDao<DicCompanyMoneyType> implements IDicCompanyMoneyTypeDao {
	
	@Override
	public Class<DicCompanyMoneyType> getEntityClass() {
		return DicCompanyMoneyType.class;
	}

}