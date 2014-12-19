package com.inspur.cams.drel.config.assistance.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.config.assistance.dao.ISamAssistanceItemDao;
import com.inspur.cams.drel.config.assistance.data.SamAssistanceItem;

/**
 * @title:救助项目dao
 * @description:
 * @author:
 * @since:2012-05-03
 * @version:1.0
 */
public class SamAssistanceItemDao extends EntityDao<SamAssistanceItem> implements ISamAssistanceItemDao {
	@SuppressWarnings("unchecked")
	public Class getEntityClass() {
		return SamAssistanceItem.class;
	}
}
