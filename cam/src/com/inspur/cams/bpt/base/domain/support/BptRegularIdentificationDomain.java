package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.base.dao.IBptRegularIdentificationDao;
import com.inspur.cams.bpt.base.data.BptRegularIdentification;
import com.inspur.cams.bpt.base.domain.IBptRegularIdentificationDomain;

/**
 * 
 * @author王宝才
 *
 */
public class BptRegularIdentificationDomain implements IBptRegularIdentificationDomain {
	
	@Reference
	private  IBptRegularIdentificationDao bptRegularIdentificationDao;
	
	/**
	 * 添加定期认证信息
	 */
	public void insert(BptRegularIdentification bptRegularIdentification){
		bptRegularIdentificationDao.insert(bptRegularIdentification);
	}
	
	/**
	 * 查询定期认证信息
	 */
	public DataSet queryRegularIdentification(ParameterSet pset){
		return bptRegularIdentificationDao.query(pset);
	}
	
	/**
	 * 查询认证详细信息
	 */
	/*public DataSet queryRIdentification(ParameterSet pset){
		return bptRegularIdentificationDao.queryRIdentification(pset);
		
	}*/

	/**
	 * 查询验证人员信息
	 */
	public DataSet queryRegIdenti(ParameterSet pset){
		return bptRegularIdentificationDao.queryRegIdenti(pset);
	}
	/**
	 * 更新验证人员信息
	 */
	public void updateRegIdenti(BptRegularIdentification bptRegularIdentification){
		bptRegularIdentificationDao.update(bptRegularIdentification);
	}
	/**
	 * 删除验证人员信息
	 */
	public void deleteRegIdenti(String[] delIds){
		bptRegularIdentificationDao.batchDelete(delIds);
	}
	/**
	 * 查询是否认证
	 */
	public DataSet queryRI(ParameterSet set) {
		// TODO Auto-generated method stub
		return bptRegularIdentificationDao.queryRI(set);
	}
}