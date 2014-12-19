package com.inspur.cams.drel.sam.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamCardNoDao;
import com.inspur.cams.drel.sam.data.SamCardNo;

/**
 * @title:低保证号dao
 * @description:
 * @author:zhangjian
 * @since:2011-06-14
 * @version:1.0
 */
public class SamCardNoDao extends EntityDao<SamCardNo> implements ISamCardNoDao {
	@SuppressWarnings("unchecked")
	public Class getEntityClass() {
		return SamCardNo.class;
	}
}
