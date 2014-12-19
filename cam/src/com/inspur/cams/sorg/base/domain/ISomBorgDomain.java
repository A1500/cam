package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.sorg.base.data.SomBorg;

/**
 * 业务主管单位domain接口
 * @author yanliangliang
 * @date 2011-6-8
 */
public interface ISomBorgDomain {
	
	/**
	 * 业务主管单位查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 业务主管单位添加
	 * @param somCert
	 * @return
	 */
	@Trans
	public String insert(SomBorg somBorg);

	/**
	 * 业务主管单位修改
	 * @param somBorg
	 */
	@Trans
	public void update(SomBorg somBorg);
	
	/**
	 * 业务主管单位删除
	 * @param somBorg
	 */
	@Trans
	public void batchDelete(String[] delIds);
	
	/**
	 * 业务主管单位变更
	 * @param somBorg
	 */
	@Trans
	public void changeBorg(SomBorg somBorg);
}
