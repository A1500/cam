package com.inspur.cams.bpt.capital.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.capital.dao.jdbc.BPTCapitalBudgetAjaxDao;
import com.inspur.cams.bpt.capital.data.BPTCapitalBudget;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

public class BPTCapitalBudgetCmd extends BaseAjaxCommand {
    
    private BPTCapitalBudgetAjaxDao dao = (BPTCapitalBudgetAjaxDao) DaoFactory.getDao(BPTCapitalBudgetAjaxDao.class);
    
    /**
     * 添加区县资金投入
     */
    @Trans
    public void addCityBudget(){
    	Record record = (Record)getParameter("record");
    	String inputId = IdHelp.getUUID32();
    	BPTCapitalBudget dataBean = (BPTCapitalBudget)record.toBean(BPTCapitalBudget.class);
    	dataBean.setInputId(inputId);
    	dataBean.setRegId(BspUtil.getCorpOrgan().getOrganCode());
    	dataBean.setRegTime(DateUtil.getTime());
    	dao.insert(dataBean);
    }
    
    /**
     * 修改区县资金投入
     */
    @Trans
    public void updateCityBudget(){
    	Record record = (Record)getParameter("record");
    	BPTCapitalBudget dataBean = (BPTCapitalBudget)record.toBean(BPTCapitalBudget.class);
    	dataBean.setModId(BspUtil.getCorpOrgan().getOrganCode());
    	dataBean.setModTime(DateUtil.getTime());
    	dao.update(dataBean);
    }
    
    /**
     * 添加中央和山东省资金投入
     */
    @Trans
    public void addProvinceBudget(){
        ParameterSet pset = getParameterSet();
        dao.addProvinceBudget(pset);
    }
    /**
     * 修改中央和山东省资金投入
     */
    @Trans
    public void updateProvinceBudget(){
        ParameterSet pset = getParameterSet();
        dao.updateProvinceBudget(pset);
    }
    
    /**
     * 删除县区资金投入信息
     */
    @Trans
    public void deleteCityBudget(){
    	ParameterSet pset = getParameterSet();
        String[] dels = (String[])pset.getParameter("dels");
        dao.batchDelete(dels);
    }
    
    /**
     * 删除中央和山东省资金投入信息
     */
    @Trans
    public void deleteProvinceBudget(){
        ParameterSet pset = getParameterSet();
        String[] inputId = (String[]) pset.getParameter("inputId");
        String[] inputId1 = (String[]) pset.getParameter("inputId1");
        dao.batchDelete(inputId);
        dao.batchDelete(inputId1);
    }
    
    /**
     * 查询本区划是否有重复年份
     */
    @Trans
    public void checkYearExist(){
    	ParameterSet pset = getParameterSet();
    	String flag = dao.checkYearExist(pset);
    	setReturn("flag",flag);
    }
}
