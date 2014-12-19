package com.inspur.cams.bpt.regulations.cmd;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.regulations.data.BptRegulations;
import com.inspur.cams.bpt.regulations.domain.IBptRegulationDomain;

public class BptRegulationsAjaxCommand extends BaseAjaxCommand {
   private IBptRegulationDomain regulationService = ScaComponentFactory.getService(IBptRegulationDomain.class,"BptRegulationDomain/BptRegulationDomain");
   @Trans
    public void addRegulation() {
        ParameterSet pset = getParameterSet();
        HttpServletRequest request = getRequest();
        MultipartRequestWrapper wrapRequest=(MultipartRequestWrapper)request;
        regulationService.insertRegulation(pset, wrapRequest);
    }
   @Trans
    public void deleteRegulations() {
        ParameterSet pset = getParameterSet();
        String[] delIds = (String[]) pset.getParameter("ids");
        regulationService.batchDelete(delIds);
    }
   @Trans
    public void updateRegulations() {
        ParameterSet pset = getParameterSet();
        Record record = (Record) pset.getParameter("record");
        HttpServletRequest request = getRequest();
        MultipartRequestWrapper wrapRequest=(MultipartRequestWrapper)request;
        BptRegulations regulation = (BptRegulations) record.toBean(BptRegulations.class);
        regulationService.update(regulation,wrapRequest);
    }

}
