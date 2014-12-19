package com.inspur.cams.drel.sam.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamIdCardDao;
import com.inspur.cams.drel.sam.data.SamIdCard;

/**
 * @title:身份代码dao
 * @description:
 * @author:zhangjian
 * @since:2011-06-18
 * @version:1.0
 */
public class SamIdCardDao extends EntityDao<SamIdCard> implements ISamIdCardDao {
	@SuppressWarnings("unchecked")
	public Class getEntityClass() {
		return SamIdCard.class;
	}
}
