package com.inspur.cams.marry.query.divorce.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.marry.query.divorce.dao.DivorcePeopleTypeQueryDao;


public class DivorcePeopleTypeQueryCmd extends BaseQueryCommand {
    
    private DivorcePeopleTypeQueryDao dao = (DivorcePeopleTypeQueryDao)DaoFactory.getDao(DivorcePeopleTypeQueryDao.class);
    /*
     * 结婚登记业务：按不同居住地分类(内地、涉外、涉港、涉奥、涉台、涉华桥)
     */
    public DataSet query(){
    	ParameterSet pset = getParameterSet();
    	DataSet ds = dao.getDataSet(pset);
    	return ds;
    }
    /**
     * 地图查询方法
     * @author yanll
     */
    public DataSet queryForGis(ParameterSet pset){
    	DataSet ds = dao.getDataSetForGis(pset);
    	return ds;
    }
}
