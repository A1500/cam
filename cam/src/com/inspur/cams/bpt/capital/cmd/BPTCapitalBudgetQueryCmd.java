package com.inspur.cams.bpt.capital.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.capital.dao.jdbc.BPTCapitalBudgetAjaxDao;

public class BPTCapitalBudgetQueryCmd extends BaseQueryCommand {
    
    private BPTCapitalBudgetAjaxDao dao = (BPTCapitalBudgetAjaxDao) DaoFactory.getDao(BPTCapitalBudgetAjaxDao.class);
    
    public DataSet queryProvince(){
        ParameterSet pset = getParameterSet();
        DataSet set = dao.queryProvince(pset);
        return  set;
    }
    public DataSet queryCity(){
        ParameterSet pset  = getParameterSet();
        return dao.query(pset);
    }
}
