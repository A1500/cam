package com.inspur.cams.drel.mbalance.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.mbalance.dao.ISamMedicalTopLineDao;
import com.inspur.cams.drel.mbalance.data.SamMedicalTopLine;
/***
 * 一站结算_救助封顶线dao实现
 * @author yanliangliang
 * @date 2011-6-15
 */
public class SamMedicalTopLineDao extends EntityDao<SamMedicalTopLine> implements ISamMedicalTopLineDao{

	@Override
	protected Class<SamMedicalTopLine> getEntityClass() {
		// TODO Auto-generated method stub
		return SamMedicalTopLine.class;
	}

}
