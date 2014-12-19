package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.base.dao.IDisabilityIdentificationDao;
import com.inspur.cams.bpt.base.data.DisabilityIdentification;
import com.inspur.cams.bpt.base.domain.IDisabilityIdentificationDomain;

/**
 * @description:添加和查询残疾情况介绍信的Domain层
 * @author 王宝才
 * @since:2011-05-18
 */
public class DisabilityIdentificationDomain  implements IDisabilityIdentificationDomain{
	
	@Reference
	private IDisabilityIdentificationDao  disabilityIdentificationDao;
	
	/**
	 * 添加残疾情况介绍信
	 */
	public void insert(DisabilityIdentification disabilityIdentification) {
		disabilityIdentificationDao.insert(disabilityIdentification);
	}
	
	/**
	 * 更新残疾情况介绍信
	 */
	public void update(DisabilityIdentification disabilityIdentification){
		disabilityIdentificationDao.update(disabilityIdentification);
	}
	
	/**
	 * 查询残疾情况介绍信
	 */
	public DataSet query(ParameterSet pset){
		return disabilityIdentificationDao.query(pset);
	}
	
	/**
	 * 获得编号最后三位的最大值
	 */
	 public String getMaxNumber(String idPre){
		 return disabilityIdentificationDao.getMaxNumber(idPre);
	 }
		
}