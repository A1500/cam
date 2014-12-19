package com.inspur.cams.sorg.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomCert;

/**
 * 社会组织证书domain接口
 * @author yanliangliang
 * @date 2011年5月17日20:41:08
 */
public interface ISomCertDomain {
	
	/**
	 * 社会组织证书查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 增加社会组织证书
	 * @param somCert
	 */
	@Trans
	public String insert(SomCert somCert);
	
	/**
	 * 更新社会组织证书
	 * @param somCert
	 */
	@Trans
	public void update(SomCert somCert);
	
	/**
	 * 换发社会组织证书
	 * @param somCert
	 */
	@Trans
	public void change(SomCert somCert);
	
	/**
	 * 批量更新社会组织证书
	 * @param somCert
	 */
	@Trans
	public void batchUpdate(List<SomCert> list);
	
	/***
	 * 收回证书 2011年5月17日20:00:55
	 * @param somCert
	 */
	@Trans
	public void receive(SomCert somCert);
	/**
	 *  综合查询中根据证书查询社会组织ID
	 * @param pset2011年5月26日9:27:28
	 * @return
	 */
	public String queryForQuery(ParameterSet pset);
	
}
