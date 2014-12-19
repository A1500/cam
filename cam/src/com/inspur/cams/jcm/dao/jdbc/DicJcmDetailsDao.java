package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IDicJcmDetailsDao;
import com.inspur.cams.jcm.data.DicJcmDetails;

/**
 * 字典详细信息dao
 * @author 
 * @date 2014-05-22
 */
public class DicJcmDetailsDao extends EntityDao<DicJcmDetails> implements IDicJcmDetailsDao {
	
	@Override
	public Class<DicJcmDetails> getEntityClass() {
		return DicJcmDetails.class;
	}

}