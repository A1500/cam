package com.inspur.cams.drel.sam.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.sam.dao.ISamTreatmentAdjustDao;
import com.inspur.cams.drel.sam.data.SamTreatmentAdjust;

/**
 * @title:待遇调整记录dao
 * @description:
 * @author: zhangjian
 * @since:2012-06-06
 * @version:1.0
 */
public class SamTreatmentAdjustDao extends EntityDao<SamTreatmentAdjust> implements ISamTreatmentAdjustDao {
	@SuppressWarnings("unchecked")
	public Class getEntityClass() {
		return SamTreatmentAdjust.class;
	}
}
