package com.inspur.cams.marry.query.dept.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.dept.dao.CertificateDao;



public class CertificateQueryCmd extends BaseQueryCommand {
    
    private CertificateDao dao = (CertificateDao)DaoFactory.getDao(CertificateDao.class);
    
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}