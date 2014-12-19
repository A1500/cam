package com.inspur.cams.welfare.base.domain.support;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.welfare.base.dao.support.WealFitProductivepowerDao;
import com.inspur.cams.welfare.base.data.WealFitProductivepower;
import com.inspur.cams.welfare.base.domain.IWealFitProductivepowerDomain;

/**
 * 假矫装配企业生产能力信息domain
 * @author 
 * @date 2013-04-19
 */
public class WealFitProductivepowerDomain implements IWealFitProductivepowerDomain {

	private WealFitProductivepowerDao wealFitProductivepowerDomain = (WealFitProductivepowerDao) DaoFactory
	.getDao("com.inspur.cams.welfare.base.dao.support.WealFitProductivepowerDao");

	/**
	 * 查询 假矫装配企业生产能力信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return wealFitProductivepowerDomain.query(pset);
	}


	/**
	 * 增加 假矫装配企业生产能力信息
	 * @param wealFitProductivepower
	 */
	public void insert(WealFitProductivepower wealFitProductivepower) {
		wealFitProductivepower.setProduceId(IdHelp.getUUID32());
		wealFitProductivepowerDomain.insert(wealFitProductivepower);
	}
	
	/**
	 * 修改 假矫装配企业生产能力信息
	 * @param wealFitProductivepower
	 */
	public void update(WealFitProductivepower wealFitProductivepower) {
		wealFitProductivepowerDomain.update(wealFitProductivepower);
	}
	
	/**
	 * 删除 假矫装配企业生产能力信息
	 * @param produceId
	 */
	public void delete(String produceId) {
		wealFitProductivepowerDomain.delete(produceId);
	}


}