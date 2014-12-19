package com.inspur.cams.bpt.query.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.query.dao.BptPeopleQueryStatisticsDao;

public class BptPeopleQueryStatisticsCmd extends BaseQueryCommand {
    
    private BptPeopleQueryStatisticsDao dao = (BptPeopleQueryStatisticsDao)DaoFactory.getDao(BptPeopleQueryStatisticsDao.class);
    
    public DataSet queryDisability(){
        ParameterSet pset = getParameterSet();
        DataSet set = dao.queryDisability(pset);
        return set;
    }
    
    
    public DataSet queryDemobilized(){
        ParameterSet pset = getParameterSet();
        DataSet set = dao.queryDemobilized(pset);
        return set;
    }
    
    public DataSet queryDemobilizedIllness(){
        ParameterSet pSet = getParameterSet();
        DataSet set = dao.queryDemobilizedIllness(pSet);
        return set;
    }

    public DataSet queryDependent(){
        ParameterSet pset = getParameterSet();
        DataSet set = dao.queryDependent(pset);
        return set;
    }
    
    public DataSet queryWarTested(){
        ParameterSet pset = getParameterSet();
        DataSet set = dao.queryWarTested(pset);
        return  set;
    }
    
    public DataSet queryCompulsory() {
    	ParameterSet pset = getParameterSet();
    	return dao.queryCompulsory(pset);
    }
    
    public DataSet queryTemporaryHelp() {
    	ParameterSet pset = getParameterSet();
    	return dao.queryTemporaryHelp(pset);
    }
    
    public DataSet queryCapitalPension() {
    	ParameterSet pset = getParameterSet();
    	return dao.queryCapitalPension(pset);
    }
    
    public DataSet queryGrant() {
    	ParameterSet pset = getParameterSet();
    	return dao.queryGrant(pset);
    }
    
    public DataSet queryBusinessManage() {
    	ParameterSet pset = getParameterSet();
    	return dao.queryBusinessManage(pset);
    }
    
    /**
     * 残疾军人伤残器械发放情况查询
     * @return
     */
    public DataSet queryAssDevices() {
    	ParameterSet pset = getParameterSet();
    	return dao.queryAssDevices(pset);
    }
    public DataSet queryRetired(){
    	ParameterSet pset = getParameterSet();
    	return dao.queryRetired(pset);
    }
    public DataSet queryMartyrOffspring(){
    	ParameterSet pset = getParameterSet();
    	return dao.queryMartyrOffspring(pset);
    }
}
