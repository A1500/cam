package com.inspur.cams.drel.mbalance.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.mbalance.dao.ISamMedicalSpPerDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalSpPer;
/***
 * 一站结算_优抚救助比例dao实现
 * @author yanliangliang
 * @date 2011-6-15
 */
public class SamMedicalSpPerDao extends EntityDao<SamMedicalSpPer> implements ISamMedicalSpPerDao{

	@Override
	protected Class<SamMedicalSpPer> getEntityClass() {
		// TODO Auto-generated method stub
		return SamMedicalSpPer.class;
	}

}
