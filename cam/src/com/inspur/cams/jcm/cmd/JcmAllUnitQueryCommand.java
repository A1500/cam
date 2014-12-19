package com.inspur.cams.jcm.cmd;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.jcm.domain.IJcmAllUnitQueryDomain;
import org.loushang.next.dao.DaoFactory;
import com.inspur.cams.jcm.dao.IJcmAllUnitQueryDao;
import com.inspur.cams.jcm.dao.jdbc.JcmAllUnitQueryDao;
import com.inspur.cams.jcm.dao.jdbc.JcmCompanyProfileDao;


/**
 * @author 陈寿业
 *所有单位表 QueryCmd
 *date 2014-12-16
 */
public class JcmAllUnitQueryCommand extends BaseQueryCommand {
	private IJcmAllUnitQueryDomain jcmAllUnitQueryDomain = ScaComponentFactory
	.getService(IJcmAllUnitQueryDomain.class, "jcmAllUnitQueryDomain/jcmAllUnitQueryDomain");
	JcmAllUnitQueryDao dao = (JcmAllUnitQueryDao) DaoFactory.getDao("com.inspur.cams.jcm.dao.jdbc.JcmAllUnitQueryDao");
public DataSet execute() {
ParameterSet pset = getParameterSet();
return jcmAllUnitQueryDomain.queryCompany(pset);
}
}
