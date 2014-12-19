package com.inspur.cams.jcm.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.jcm.dao.jdbc.JcmCompanyProfileDao;
import com.inspur.cams.jcm.domain.IJcmCompanyProfileDomain;

/**
 * 单位信息查询cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmCompanyProfileQueryCmd extends BaseQueryCommand {

	private IJcmCompanyProfileDomain jcmCompanyProfileDomain = ScaComponentFactory
			.getService(IJcmCompanyProfileDomain.class, "jcmCompanyProfileDomain/jcmCompanyProfileDomain");
	JcmCompanyProfileDao dao = (JcmCompanyProfileDao) DaoFactory.getDao("com.inspur.cams.jcm.dao.jdbc.JcmCompanyProfileDao");

	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds = jcmCompanyProfileDomain.query(pset);
		ds.getMetaData().setIdProperty("companyId");
		return ds;
	}
	public DataSet queryCompany() {
		ParameterSet pset = getParameterSet();
		return jcmCompanyProfileDomain.queryCompany(pset);
	}
	public DataSet queryUserinfo(){
		ParameterSet pset = getParameterSet();
		return jcmCompanyProfileDomain.queryUserinfo(pset);
	}
	
	public DataSet queryCompanyInfo(){
		ParameterSet pset = getParameterSet();
		return jcmCompanyProfileDomain.queryCompanyInfo(pset);
	}
	public DataSet getOrgan() {
		ParameterSet ps = getParameterSet();
		String orderCompanyId = (String) ps.getParameter("companyId");
		return dao.getOrgan(orderCompanyId);
	}
}