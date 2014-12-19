package com.inspur.cams.bpt.regulations.domain;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.regulations.dao.IBptRegulationsAttachmentDao;
import com.inspur.cams.bpt.regulations.dao.IBptRegulationsDao;
import com.inspur.cams.bpt.regulations.data.BptRegulations;
import com.inspur.cams.bpt.regulations.data.BptRegulationsAttachment;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

public class BptRegulationDomain implements IBptRegulationDomain{
    
    @Reference
    private IBptRegulationsDao regulationsDao;
    @Reference
    private IBptRegulationsAttachmentDao attachmentDao;

    public void batchDelete(String[] delIds) {
        regulationsDao.batchDelete(delIds);
        attachmentDao.batchDeleteByRegulationId(delIds);
    }

    public void insertRegulation(ParameterSet pset, MultipartRequestWrapper wrapRequest) {
        Record record = (Record) pset.getParameter("record");
        BptRegulations regulation = (BptRegulations) record.toBean(BptRegulations.class);
        regulationsDao.insert(regulation);
        // 保存附件信息
        Map<String, UploadFile> map = wrapRequest.getUploadFiles();
        Set<Entry<String, UploadFile>> set = map.entrySet();
        Iterator<Entry<String, UploadFile>> iterator = set.iterator();
        UploadFile uploadfile = null;
        BptRegulationsAttachment attachment = null;
        // 用于存放所有附件的名字
        List<String> filenames = new ArrayList<String>();
        List<String> prefilenames = new ArrayList<String>();
        String filename = null;
        // 遍历Map，封装成BptRegulationsAttachment对象，并放入List中。
        List<BptRegulationsAttachment> list = new ArrayList<BptRegulationsAttachment>();
        while (iterator.hasNext()) {
            uploadfile = iterator.next().getValue();
            if (uploadfile.getFileSize() > 5 * 1024 * 1024) {
                throw new RuntimeException(uploadfile.getFileName() + " 文件过大，上传文件不能超过5M！");
            }
            // 如果文件名相同，则只保存第一条，其余的放弃。
            filename = uploadfile.getFileName();
            if (filenames.contains(filename)) {
                continue;
            }
            filenames.add(filename);
            prefilenames.add(filename);
            attachment = new BptRegulationsAttachment();
            attachment.setAttachmentId(IdHelp.getUUID32());
            attachment.setRegulationsId(regulation.getRegulationsId());
            attachment.setUploadtime(DateUtil.getDay());
            attachment.setFileName(uploadfile.getFileName());
            attachment.setAttachment(uploadfile);
            list.add(attachment);
        }
        attachmentDao.batchInsert(list);
    }

    public DataSet query(ParameterSet pset) {
        
        return regulationsDao.query(pset);
    }

    public void update(BptRegulations regulation,MultipartRequestWrapper wrapRequest) {
       regulationsDao.update(regulation);
    // 保存附件信息
       Map<String, UploadFile> map = wrapRequest.getUploadFiles();
       Set<Entry<String, UploadFile>> set = map.entrySet();
       Iterator<Entry<String, UploadFile>> iterator = set.iterator();
       UploadFile uploadfile = null;
       BptRegulationsAttachment attachment = null;
       // 用于存放所有附件的名字
       List<String> filenames = new ArrayList<String>();
       List<String> prefilenames = new ArrayList<String>();
       String filename = null;
       // 遍历Map，封装成BptRegulationsAttachment对象，并放入List中。
       List<BptRegulationsAttachment> list = new ArrayList<BptRegulationsAttachment>();
       while (iterator.hasNext()) {
           uploadfile = iterator.next().getValue();
           if (uploadfile.getFileSize() > 5 * 1024 * 1024) {
               throw new RuntimeException(uploadfile.getFileName() + " 文件过大，上传文件不能超过5M！");
           }
           // 如果文件名相同，则只保存第一条，其余的放弃。
           filename = uploadfile.getFileName();
           if (filenames.contains(filename)) {
               continue;
           }
           filenames.add(filename);
           prefilenames.add(filename);
           attachment = new BptRegulationsAttachment();
           attachment.setAttachmentId(IdHelp.getUUID32());
           attachment.setRegulationsId(regulation.getRegulationsId());
           attachment.setUploadtime(DateUtil.getDay());
           attachment.setFileName(uploadfile.getFileName());
           attachment.setAttachment(uploadfile);
           list.add(attachment);
       }
       attachmentDao.batchInsert(list);
    }

}
