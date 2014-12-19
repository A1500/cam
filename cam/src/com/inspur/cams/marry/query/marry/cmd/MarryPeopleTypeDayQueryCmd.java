package com.inspur.cams.marry.query.marry.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.marry.dao.MarryPeopleTypeDayQueryDao;

public class MarryPeopleTypeDayQueryCmd extends BaseQueryCommand {
    
    private MarryPeopleTypeDayQueryDao dao = (MarryPeopleTypeDayQueryDao)DaoFactory.getDao(MarryPeopleTypeDayQueryDao.class);
    /*
     * 结婚登记业务：按不同居住地分类(内地、涉外、涉港、涉奥、涉台、涉华桥)
     */
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    
}
