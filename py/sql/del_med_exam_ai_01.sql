DELETE
FROM med_exam_ai
WHERE usr_id = %s
  AND model <> 'claude-3-5-sonnet-20240620'