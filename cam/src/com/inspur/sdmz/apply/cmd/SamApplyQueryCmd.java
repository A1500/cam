package com.inspur.sdmz.apply.cmd;


import org.loushang.bsp.security.context.BspInfo;
import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.sdmz.apply.data.SamApply;
import com.inspur.sdmz.apply.domain.ISamApplyDomain;

/**
 * 业务申请对应的Command
 * @author Administrator
 * @date 2011-4-23
 */
public class SamApplyQueryCmd extends BaseQueryCommand {

	ISamApplyDomain samapplyDomain = ScaComponentFactory.getService(ISamApplyDomain.class,
			"SamApplyDomain/SamApplyDomain");
	/**
	 * 更新页面指向的查询Cmd里的方法
	 * @return dao.query(pset)
	 */
	public DataSet samapplyUpdate() {
		ParameterSet pset = getParameterSet();
		DataSet ds=samapplyDomain.query(pset);
		BspInfo bspInfo = GetBspInfo.getBspInfo();
		String str=bspInfo.getUserName();
		SamApply samapply=(SamApply) ds.getRecord(0).toBean(SamApply.class);
		samapply.setCurrentHanPeo(str);
		Record re=new Record(samapply);
		DataSet ds1=new DataSet(re);
		return ds1;
	}
	
	/**
	 * 查询页面指向的Cmd
	 * @return ds
	 */
	public DataSet samapplyQuery(){
		BspInfo bspInfo = GetBspInfo.getBspInfo();
		String value = bspInfo.getCorporationOrganId();
		ParameterSet pset = getParameterSet();
		pset.setParameter("CURRENT_ORG", value);
		pset.setParameter("HANDLE_SIGN", "0");
		DataSet ds = samapplyDomain.query(pset);
		return ds;
	}
	
	/**
	 * 页面明细列表指向的Cmd
	 * @return dao.query(pset)
	 */
	public DataSet detail() {
		//BspInfo bspInfo = GetBspInfo.getBspInfo();
		//String value = bspInfo.getCorporationOrganId();
		ParameterSet pset = getParameterSet();
		//pset.setParameter("DQDW_ID", value);
		DataSet ds=samapplyDomain.query(pset);
		return ds;
	}

	/**
	 * 办理历史页面明细列表指向的Cmd
	 * @return dao.query(pset)
	 */
	public DataSet ywlsQuery() {
		ParameterSet pset = getParameterSet();
		DataSet ds=samapplyDomain.ywlsQuery(pset);
		return ds;
	}
	/**
	 * 审核查询页面指向的Cmd
	 * @return ds
	 */
	public DataSet samapplyshQuery(){
		BspInfo bspInfo = GetBspInfo.getBspInfo();
		String value = bspInfo.getCorporationOrganId();
		ParameterSet pset = getParameterSet();
		pset.setParameter("CURRENT_ORG", value);
		pset.setParameter("HANDLE_SIGN", "1");
		DataSet ds = samapplyDomain.query(pset);
		return ds;
	}
}